#!/usr/bin/env python3

import random
import requests
from datetime import datetime, timezone

HOST = "http://localhost:8010/api/v1/telemetry"

USERNAME = "user"
PASSWORD = "password"

MIN_VALUE = 1
MAX_VALUE = 70


def generate_payload():
    return {
        "deviceId": "sensor-temp-1",
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "metric": "temperature",
        "value": round(random.uniform(MIN_VALUE, MAX_VALUE), 2)
    }


def send_telemetry():
    payload = generate_payload()

    print("Sending payload:")
    print(payload)

    response = requests.post(
        HOST,
        json=payload,
        auth=(USERNAME, PASSWORD),
        headers={
            "Content-Type": "application/json"
        }
    )

    print("\nStatus:")
    print(response.status_code)

    print("\nResponse headers:")
    print(response.headers)

    print("\nResponse body:")
    print(response.text)

    location = response.headers.get("Location")

    if location:
        print(f"\nFetching resource from: {location}")

        get_response = requests.get(
            location,
            auth=(USERNAME, PASSWORD)
        )

        print("\nGET status:")
        print(get_response.status_code)

        print("\nGET body:")
        print(get_response.text)


if __name__ == "__main__":
    send_telemetry()
    print("\nScript finished!")