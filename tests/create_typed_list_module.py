import torch
from typing import Dict, Tuple, List

class Foo(torch.jit.ScriptModule):
    def __init__(self):
        super(Foo, self).__init__()

    @torch.jit.script_method
    def list_list_int(self, val: List[List[int]]) -> List[List[int]]:
        return val

    @torch.jit.script_method
    def list_list_int_len(self, val: List[List[int]]) -> List[int]:
        return [len(x) for x in val]

foo = Foo()
foo.save('typed_list.pt')
