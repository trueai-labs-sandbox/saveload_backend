# Loaded by gunicorn from the working directory. With PROMETHEUS_MULTIPROC_DIR set,
# every worker writes its metrics there and /metrics sums them; drop a dead worker's
# live gauges so they do not linger.
import os


def child_exit(server, worker):
    if os.environ.get("PROMETHEUS_MULTIPROC_DIR"):
        from prometheus_client import multiprocess

        multiprocess.mark_process_dead(worker.pid)
