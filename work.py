import re
import os
with open("base.txt", 'r', encoding='utf-16-le') as f:
    base = f.read()
with open("attach.txt", 'r', encoding='utf-16-le') as f:
    attach = f.read()


def parse(s):
    res = re.fullmatch(r"(.*)\[Text\]\n(.*)", s, re.DOTALL)
    s = res.group(2)
    res = []
    for line in s.splitlines():
        terms = line.split(' ')
        for i in range(1, len(terms)):
            res.append((terms[0], terms[i]))
    return res

def remove_tag(s):
    code, word = s
    if word[0] == '~' or word[0] == '^':
        return (code, word[1:])
    else:
        return (code, word)
    
def replace_special(s):
    code, word = s
    word = word.replace("$20", " ")
    return code, word

def filter_pinyin(s):
    code, word = s
    if len(word) > 1:
        return False
    if 0x4E00 <= ord(word) <= 0x9FFF:
        return False
    if 0x3000 <= ord(word) <= 0x303F:
        return False
    if word == "●":
        return False
    # if ord(word) >= 0x10000:
    #     return False
    if len(code) > 4:
        return False
    if re.fullmatch(r"v[ghtyn]+", code) is not None and word != "犯":
        return False

    return True
    

base = parse(base) 
attach = parse(attach)


base = map(remove_tag, base)
base = map(replace_special, base)
attach = map(remove_tag, attach)
attach = filter(filter_pinyin, attach)


# print()

ans = list(base) + list(attach)
with open("wubi091.dict.head.yaml", 'r', encoding='utf-8') as f:
    s = f.read()
s += "\n".join([f"{e[0]}\t{e[1]}" for e in ans])
s += '\n'
os.makedirs("dist", exist_ok=True)
with open("dist/wubi091.dict.yaml", 'w', encoding='utf-8') as f:
    f.write(s)

  

