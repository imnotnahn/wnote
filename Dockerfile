FROM python:3.9-slim

WORKDIR /app

COPY . /app/

RUN pip install --no-cache-dir -e .

RUN mkdir -p /root/.config/wnote/attachments

ENTRYPOINT ["wnote"]
CMD ["--help"] 