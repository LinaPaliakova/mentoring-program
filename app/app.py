from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello palina, you are doing great"

if __name__ == '__main__':
    app.run()
