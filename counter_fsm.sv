module counter_fsm #(
    parameter N=32
)
    (
        input logic clk,
        input logic reset_n,
        output logic [$clog2(N)-1 :0]out);

    logic [$clog2(N)-1 :0]temp;

    typedef enum {IDLE,NEXT} state;

    state next_state;
    state current_state;

    always_ff@(posedge clk or negedge reset_n)
    begin
        if(!reset_n)
        begin
            current_state <= IDLE;
        end
        else
        begin
            current_state <= next_state;
        end
    end


    always_comb
    begin
        temp   = '0;
        case (current_state)

            IDLE : 
                begin
                    if(temp == N-1)
                    begin
                        temp='b0;
                        next_state = NEXT;
                    end

                    else 
                    begin
                        temp = temp +'b1;
                        next_state = NEXT;
                    end
                end

            NEXT :
                begin

                    if(temp == N-1)
                    begin
                        temp = 'b0;
                        next_state = IDLE;
                    end
                    else
                    begin
                        temp = temp + 'b1;
                        next_state = IDLE;
                    end
                end
        endcase
    end

    assign out = temp;


endmodule
