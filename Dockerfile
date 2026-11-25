FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

COPY site.tar.gz /tmp/site.tar.gz
RUN tar -xzf /tmp/site.tar.gz -C /app && rm /tmp/site.tar.gz \
    && mkdir -p data/out data/uploads data/textbooks

EXPOSE 8770

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD python -c "import urllib.request;urllib.request.urlopen('http://127.0.0.1:8770/api/health',timeout=3)"

CMD ["python", "run.py", "--host", "0.0.0.0", "--port", "8770"]