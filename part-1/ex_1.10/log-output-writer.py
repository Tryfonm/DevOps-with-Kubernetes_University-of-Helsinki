import time
from datetime import datetime
import random
import string
import logging


logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("log-output-writer")
FILE_PATH = "/usr/src/app/files/log-output.log"


def write_string():
    try:
        random_str = "".join(random.choice(string.ascii_letters) for _ in range(36))
        while True:
            current_time = datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S.%fZ")
            with open(FILE_PATH, "w") as f:
                f.write(f"{current_time}: {random_str}")
            time.sleep(5)
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    write_string()
