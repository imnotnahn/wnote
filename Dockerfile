FROM python:3.9-slim

WORKDIR /app

# Copy all necessary files
COPY requirements.txt pyproject.toml setup.py ./
COPY wnote.py __init__.py ./
COPY README.md CHANGELOG.md LICENSE ./

# Install the package
RUN pip install --no-cache-dir -e .

# Create config directory
RUN mkdir -p /root/.config/wnote/attachments

ENTRYPOINT ["wnote"]
CMD ["--help"] 