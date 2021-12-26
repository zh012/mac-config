#!/usr/local/anaconda3/bin/python

import os
import json
from pathlib import Path
import datetime as dt
import boto3
import pyotp


def current_awsenv():
    suffixes = Path(os.readlink(os.path.expanduser("~/.aws/credentials"))).suffixes
    awsenv = suffixes[0].strip(".")
    if len(suffixes) > 1:
        role = suffixes[1].strip(".")
    else:
        role = None
    return awsenv, role


awsenv_config_json_example = [
    {
        "name": "The main account",
        "short_name": "main",
        "region": "ap-south-1",
        "aws_access_key_id": "xxxxx",
        "aws_secret_access_key": "yyyyyy",
        "mfa_serial_number": "arn:aws:iam::11111111111:mfa/main@hzj.com",
        "mfa_otp_seed": "zzzzzzzzzz",
        "roles": [
            {
                "name": "fintech",
                "region": "ap-south-1",
                "arn": "arn:aws:iam::222222222222:role/FintechDeveloper"
            },
            {
                "name": "meta",
                "region": "ap-south-1",
                "arn": "arn:aws:iam::33333333333:role/MetaDeveloper"
            }
        ]
    }
]

def get_awsenv_config(awsenv):
    awsenv_config = json.loads(
        Path("~/.aws/awsenv.config.json").expanduser().read_text()
    )
    return next((env for env in awsenv_config if env["short_name"] == awsenv), None)


def get_cached_awsenv_session(session_path):
    return None
    # if session_path.is_file():
    #     session = json.loads(session_path.read_text())
    #     expiration = dt.datetime.fromisoformat(session["Credentials"]["Expiration"])
    #     if expiration - dt.datetime.now(dt.timezone.utc) > dt.timedelta(minutes=30):
    #         return session


def get_awsenv_session(awsconfig):
    sts = boto3.client(
        "sts",
        region_name=awsconfig["region"],
        aws_access_key_id=awsconfig["aws_access_key_id"],
        aws_secret_access_key=awsconfig["aws_secret_access_key"],
    )
    return sts.get_session_token(
        DurationSeconds=129600,
        SerialNumber=awsconfig["mfa_serial_number"],
        TokenCode=pyotp.TOTP(awsconfig["mfa_otp_seed"]).now(),
    )


def auth_awsenv(awsenv, role=None):
    awsconfig = get_awsenv_config(awsenv)
    roleinfo = None
    if role:
        roles = awsconfig.get('roles')
        if roles:
            roleinfo = next((r for r in roles if r["name"] == role), None)
        if not roleinfo:
            print(f"No configuration role {role} in {awsenv}")
            return

    if not awsconfig:
        return

    session_path = Path(f"~/.aws/session.{awsenv}").expanduser()
    session = get_cached_awsenv_session(session_path)

    if session:
        print(": The current session is still valid.")
    else:
        session = get_awsenv_session(awsconfig)
        session["Credentials"]["Expiration"] = session["Credentials"]["Expiration"].isoformat()
        session_path.write_text(json.dumps(session))
        print(": Session refreshed.")

    if not roleinfo:
        content = f"""[default]
region = {awsconfig["region"]}
aws_access_key_id = {session["Credentials"]["AccessKeyId"]}
aws_secret_access_key = {session["Credentials"]["SecretAccessKey"]}
aws_session_token = {session["Credentials"]["SessionToken"]}
"""
    else:
        content = f"""[default]
source_profile = {awsenv}
region = {roleinfo["region"]}
role_arn = {roleinfo["arn"]}
[{awsenv}]
aws_access_key_id = {session["Credentials"]["AccessKeyId"]}
aws_secret_access_key = {session["Credentials"]["SecretAccessKey"]}
aws_session_token = {session["Credentials"]["SessionToken"]}
"""

    suffix = awsenv
    if role:
        suffix += '.' + role
    Path(f"~/.aws/credentials.{suffix}").expanduser().write_text(content)


if __name__ == "__main__":
    auth_awsenv(*current_awsenv())
