FROM cumulusnetworks/quagga

RUN apt-get update && \
    apt-get install -y \
      python3

COPY ./start.sh /usr/lib/quagga/start.sh
COPY ./start.py /usr/lib/quagga/start.py

ENTRYPOINT ["/usr/lib/quagga/start.sh"]
