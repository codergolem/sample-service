from service.app import main, health


def test_main_request():
    result = main()
    expected = '{"name": "oak"}'
    assert result == expected

def test_health_endpoint():
    result = health()
    assert result.status == '200 OK'