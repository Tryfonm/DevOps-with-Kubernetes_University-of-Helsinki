import time
import random
import string
import datetime


def generate_random_string(length=1):
    return "".join(random.choice(string.ascii_letters) for _ in range(length))


def main():
    try:
        random_str = generate_random_string(length=36)
        while True:
            current_time = datetime.datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S.%fZ")
            print(f"{current_time}: {random_str}")
            time.sleep(5)
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
