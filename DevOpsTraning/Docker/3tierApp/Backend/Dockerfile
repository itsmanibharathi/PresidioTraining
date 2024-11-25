FROM python:3.13-alpine

WORKDIR /app

COPY app.py /app/

RUN pip install flask pymysql cryptography flask_cors

EXPOSE 6001

CMD ["python", "app.py"]
