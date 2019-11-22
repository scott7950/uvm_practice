 
Class env extends uvm_env;
    uvm_domain env_domain;//create a domain handle
    int jump;
   
    function new(string name, uvm_component parent);
        super.new(name, parent);
        jump = 1;
    endfunction: new

    virtual task post_main_phase(uvm_phase phase);
        env_domain = uvm_domain::get_uvm_domain();
        set_domain(env_domain);
    
        if(jump == 1) begin
            env_domain.jump_all(uvm_pre_reset_phase::get());
        end
    endtask: post_main_phase
endclass:env
