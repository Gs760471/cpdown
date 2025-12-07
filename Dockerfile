FROM python:3.12-slim

# Install system deps
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ffmpeg \
        aria2 \
        libffi-dev \
        musl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy only requirements first (better caching)
COPY requirements.txt /app/requirements.txt

# Install Python packages
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Now copy the rest of the project
COPY . /app/

CMD ["python", "main.py"]

