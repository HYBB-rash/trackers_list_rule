# url: https://cf.trackerslist.com/all.txt
# 根据 https://cf.trackerslist.com/all.txt 的内容生成 mihomo 可以识别的分流规则 rule set yaml

import requests

def fetch_trackers(url: str) -> list:
    response = requests.get(url)
    response.raise_for_status()
    return response.text.splitlines()

if __name__ == "__main__":
    url = "https://cf.trackerslist.com/all.txt"
    trackers = fetch_trackers(url)
    
    # 过滤掉空行和注释行
    trackers = [tracker.strip() for tracker in trackers if tracker.strip() and not tracker.startswith("#")]
    
    # 生成规则集
    rule_set = {
        "rules": [{"type": "tracker", "value": tracker} for tracker in trackers]
    }
    
    # 输出规则集
    print(rule_set)