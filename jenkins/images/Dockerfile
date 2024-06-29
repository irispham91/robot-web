FROM python:3.9.0-buster

RUN apt-get update \
    && apt-get install -y xvfb wget ca-certificates fonts-liberation libasound2 libatk-bridge2.0-0 \
    libatk1.0-0 libatspi2.0-0 libcups2 libdbus-1-3 libgbm1 libgtk-3-0 libnspr4 libnss3 \
    libxcomposite1 libxkbcommon0 libxrandr2 xdg-utils ntpdate openssl \
    libu2f-udev libvulkan1 zip

# from requirements.txt
RUN python3 -m pip install bcrypt==3.2 \
    && pip install python-dateutil==2.8.2 \
    && pip install requests==2.26.0 \
    && pip install robotframework==4.1.2 \
    && pip install robotframework-jsonlibrary==0.3.1 \
    && pip install robotframework-pabot==2.18.0 \
    && pip install robotframework-pythonlibcore==2.1.0 \
    && pip install robotframework-requests==0.9.2 \
    && pip install robotframework-selenium-mouseextensions==0.1 \
    && pip install robotframework-seleniumlibrary==5.1.3 \
    && pip install selenium==3.141.0 \
    && pip install urllib3==1.26.18

# chromedriver v125
COPY chromedriver-linux64.zip /chromedriver-linux64.zip

# install chrome and chromedriver in one run command to clear build caches for new versions (both version need to match)
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome*.deb \
    && rm google-chrome*.deb \
    #&& wget -q https://chromedriver.storage.googleapis.com/106.0.5249.61/chromedriver_linux64.zip \
    && unzip chromedriver-linux64.zip \
    && mv chromedriver-linux64/chromedriver /usr/local/bin \
    && chmod +x /usr/local/bin/chromedriver \
    && rm chromedriver-linux64.zip \
    && rm -rf chromedriver-linux64
