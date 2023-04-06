use tch::{jit::TypePtr, IValue};

// def list_list_int(self, val: List[List[int]]) -> List[List[int]]:
// def list_list_int_lens(self, val: List[List[int]]) -> List[int]:
#[test]
fn jit() {
    let t_0 = TypePtr::Int;
    let val_0 = IValue::TypedList(vec![IValue::Int(1), IValue::Int(2)], t_0.clone());
    let val_1 = IValue::TypedList(vec![], t_0.clone());
    println!("t_0: {}", t_0.to_str().unwrap());
    let t_1 = TypePtr::List(Box::new(t_0));
    println!("t_1: {}", t_1.to_str().unwrap());
    let val = IValue::TypedList(vec![val_0, val_1], t_1);
    println!("val: {:?}", val);
    let module = tch::CModule::load("tests/typed_list.pt").unwrap();
    let result = module.method_is("list_list_int", &[val]).unwrap();
    println!("{:?}", result);
    let result = module.method_is("list_list_int_len", &[result]).unwrap();
    println!("{:?}", result);
}
