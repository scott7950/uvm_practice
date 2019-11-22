
virtual task body();

uvm_object uvm_obj_q[$];
uvm_ojbection obj = starting_phase.get_objection();

forever begin
obj.get_objectors(uvm_obj_q);

foreach(uvm_obj_q[i]) begin
  `uvm_info(get_full_name(), $psprintf("%s %s %0d", uvm_obj_q[i].get_full_name, uvm_obj_q[i].get_name(), obj.get_objection_count(uvm_obj_q[i])), UVM_LOW)
end
end
endtask
