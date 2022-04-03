import requests

HOST = "http://localhost:8080/"


def test_main_endpoint():
    response = requests.get(f"{HOST}/tree")
    expected = '{"name": "oak"}'
    result = response.content.decode("utf-8")
    assert expected == result
    
def test_health_endpoint():
    response = requests.get(f"{HOST}/tree")
    expected = 200
    assert expected == response.status_code

def test_post_and_put_not_allowed():
    response_post = requests.post(f"{HOST}/tree", data={})
    expected = 405
    assert expected == response_post.status_code
    response_put = requests.put(f"{HOST}/tree", data={})
    assert expected == response_put.status_code