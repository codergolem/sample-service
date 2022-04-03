from flask import Flask
from flask import Response
import json
app = Flask(__name__)

@app.route('/tree', methods = ['GET'])
def main():
     return json.dumps({'name': 'oak'})


@app.route('/health', methods = ['GET'])
def health():
     return Response(status = 200)

