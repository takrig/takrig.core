import os
import sys
from datetime import datetime

from src.utils.logger import logger


def application_health_checker():
    try:
        if datetime.timestamp(datetime.now()) - os.path.getmtime('/tmp/healthcheck.txt') < 120.000:
            logger.debug('Application health checker return True')
            sys.exit(0)
        else:
            logger.debug('Application health checker return False')
            sys.exit(1)
    except Exception as err:
        logger.error(f"Error on check the application health - {err}")
        sys.exit(1)


if __name__ == '__main__':
    application_health_checker()
