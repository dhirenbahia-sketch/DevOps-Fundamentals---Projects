
#Stage 1

FROM python:3.8-slim as Build

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libmariadb-dev \
    pkg-config

    COPY . .

    RUN pip install flask mysqlclient

    #Stage 2: Production Stage

    FROM python:3.8-slim

    WORKDIR /app

    COPY --from=Build /app /app
    COPY --from=Build /usr/local/lib/python3.8/site-packages/ /usr/local/lib/python3.8/site-packages/
    COPY --from=Build /usr/local/bin/ /usr/local/bin/
    
    EXPOSE 5002

     CMD ["python", "app.py"]