# Chart save/load storage (TradingView Advanced Charts), one gunicorn process.
FROM public.ecr.aws/docker/library/python:3.8-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 PORT=8080
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
RUN useradd --uid 10001 app
USER 10001
EXPOSE 8080
CMD ["sh", "-c", "exec gunicorn charting_library_charts.wsgi --bind 0.0.0.0:$PORT --workers ${WEB_CONCURRENCY:-3}"]
