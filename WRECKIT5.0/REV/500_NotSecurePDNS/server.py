from flask import Flask, request, jsonify, send_file
from Crypto.Util.number import getPrime, bytes_to_long, long_to_bytes
import os
from io import BytesIO

app = Flask(__name__)
env_key = b'REDACTED'

@app.route('/encrypt', methods=['POST'])
def encrypt_file():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part in the request'}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400

    global env_key
    x = bytes_to_long(env_key)
    p = getPrime(1024)

    file_bytes = file.read()
    print(file_bytes)
    parseData = file_bytes.split(b'\n')
    returnData = b''
    for filebytesdata in parseData:
        enc_message = long_to_bytes(pow(bytes_to_long(filebytesdata), x, p))
        returnData+=b'--START--'+enc_message.hex().encode()+b'--END--\n'
    returnData += b'--PUBS--'+hex(p)[2:].encode()+b'--END--'
    print(returnData)
    
    output = BytesIO(returnData)
    output.seek(0)
    return send_file(output, as_attachment=True, download_name='enc', mimetype='application/octet-stream')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
