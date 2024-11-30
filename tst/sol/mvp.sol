――― Source Code ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
int main() {
  return 0;
}

――― Abstract Syntax ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
{'function': {'type': 'int',
              'identifier': 'main',
              'routine': {'return': {'expression': {'value': '0'}}}}}
――― Internal Representation ――――――――――――――――――――――――――――――――――――――――――――――――――――
[{'LOC': {'tgt': '*main'}}, {'RET': {'tgt': '#0'}}]
――― Target Code (Post-Processed) ―――――――――――――――――――――――――――――――――――――――――――――――
main:
	push rbp
	mov rbp, rsp
	mov rax, 0
	pop rbp
	ret

