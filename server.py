
from gevent.pywsgi import WSGIServer
from service.app import app


if __name__ == "__main__":
    http_server = WSGIServer(('0.0.0.0', 80), app)
    http_server.serve_forever()
    exit(0)