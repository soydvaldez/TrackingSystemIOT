#!/usr/bin/env python3
# send telemetry data to the sensor-telemetry microservice
# with values in the range [1, 70]
# data must be sent with an interval of 1 second
# there must be a way to stop the script
# the script should print the response from the microservice
# the script should print the status code from the microservice
# the script should print the headers from the microservice
# the script should print the body from the microservice
# the script should print the location from the microservice


import random
import requests
import json
from datetime import datetime, timezone

HOST = "http://localhost:8010/api/v1/devices/telemetry"

USERNAME = "user"
PASSWORD = "password"

MIN_VALUE = 1
MAX_VALUE = 70


# "deviceTimestamp": datetime.now(timezone.utc).isoformat()
def generate_payload_temp():
    return {
        "type": "temperature",
        "value": round(random.uniform(MIN_VALUE, MAX_VALUE), 2)
    }

def generate_payload_hum():
    return {
        "type": "humidity",
        "value": round(random.uniform(MIN_VALUE, MAX_VALUE), 2)
    }


def generate_payload_gps():
    return {
        "type": "gps",
        "value": {
            "latitude": round(random.uniform(-90, 90), 6),
            "longitude": round(random.uniform(-180, 180), 6)
        }
    }

def generate_payload():
    return {
        "deviceUuid": "123e4567-e89b-12d3-a456-426614174000",
        "deviceTimestamp": datetime.now(timezone.utc).isoformat(),
        "measurements": [
            generate_payload_temp(),
            generate_payload_hum(),
            generate_payload_gps()
        ]
    }

def send_telemetry(payload):
    response = requests.post(
        HOST,
        json=payload,
        auth=(USERNAME, PASSWORD),
        headers={
            "Content-Type": "application/json",
            "X-API-KEY": "super-secret-key"
        }
    )

    # print("\nStatus:")
    # print(response.status_code)

    # print("\nResponse headers:")
    # print(response.headers)

    # print("\nResponse body:")
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
    for _ in range(1):
      payload = generate_payload()
    #   print(json.dumps(payload, indent=4))
      send_telemetry(payload)
