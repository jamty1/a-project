FROM python:3.9

RUN pip install pymysql boto3 mlflow

EXPOSE 5000

CMD mlflow server \
    --host 0.0.0.0 \
    --port 5000 \
    --backend-store-uri mysql+pymysql://${DB_USER}:${DB_PASSWORD}@${DB_URL}/${DATABASE} \
    --default-artifact-root ${BUCKET}