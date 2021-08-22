from src.utils.logger import logger


def application_healthcheck() -> bool:
    try:
        f = open('/tmp/healthcheck.txt', "w")
        f.write('.')
        f.close()
        return True
    except Exception as err:
        logger.error(f'Error on save the health check file - Error: {err}')
        return False
