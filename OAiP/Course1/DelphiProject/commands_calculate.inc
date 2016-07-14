      case expression[i] of
        '+':
        begin
          strA := pop(stack).operand;
          strB := pop(stack).operand;
          a := operandToNumber(strA, operands);
          b := operandToNumber(strB, operands);
          push(stack, FloatToStr(b + a));
        end;
        '-':
        begin
          strA := pop(stack).operand;
          strB := pop(stack).operand;
          a := operandToNumber(strA, operands);
          b := operandToNumber(strB, operands);
          push(stack, FloatToStr(b - a));
        end;
        '*':
        begin
          strA := pop(stack).operand;
          strB := pop(stack).operand;
          a := operandToNumber(strA, operands);
          b := operandToNumber(strB, operands);
          push(stack, FloatToStr(b * a));
        end;     
        '/':
        begin
          strA := pop(stack).operand;
          strB := pop(stack).operand;
          a := operandToNumber(strA, operands);
          b := operandToNumber(strB, operands);
          if a = 0 then
          begin
            push(stack, '1 ');
            errors := errors or errDIV0;
          end
          else
            push(stack, FloatToStr(b / a));
        end;
        #25:
        begin
          strA := pop(stack).operand;
          strB := pop(stack).operand;
          a := operandToNumber(strA, operands);
          b := operandToNumber(strB, operands);  
          if a = 0 then
          begin
            push(stack, '1 ');
            errors := errors or errDIV0;
          end
          else
          begin
            while b > a do
              b := b - a;
            push(stack, FloatToStr(b));
          end;
        end;
        #26:
        begin
          strA := pop(stack).operand;
          strB := pop(stack).operand;
          a := operandToNumber(strA, operands);
          b := operandToNumber(strB, operands);
          if a = 0 then
          begin
            push(stack, '1 ');
            errors := errors or errDIV0;
          end
          else
          begin
            temp := 0;
            while b > a do
            begin
              b := b - a;
              temp := temp + 1;
            end;
            push(stack, FloatToStr(temp));
          end;
        end;
        #23:
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands);
          push(stack, FloatToStr(abs(a)));
        end;
        '^':
        begin
          strA := pop(stack).operand;
          strB := pop(stack).operand;
          a := operandToNumber(strA, operands);
          b := operandToNumber(strB, operands);
          if (isZero(b)) and (a < 0) then
          begin
            push(stack, '1 ');
            errors := errors or errDIV0;
          end
          else
            push(stack, FloatToStr(power(b, a)));
        end;
        #17:
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands);
          if a <= 0 then
          begin
            push(stack, '1 ');
            errors := errors or errLN;
          end
          else
            push(stack, FloatToStr(ln(a)));
        end;
        #19:
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands);
          if a <= 0 then
          begin
            push(stack, '1 ');
            errors := errors or errLG;
          end
          else
            push(stack, FloatToStr(log10(a)));
        end;
        #21:
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands);
          if a <= 0 then
          begin
            push(stack, '1 ');
            errors := errors or errLOG;
          end
          else
            push(stack, FloatToStr(log2(a)));
        end;
        #1:
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands);
          push(stack, FloatToStr(sin(a)));
        end;
        #3:
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands);
          push(stack, FloatToStr(cos(a)));
        end;
        #5:
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands);
          if isZero(a - Pi/2, 0.000000001) then
          begin
            push(stack, '1 ');
            errors := errors or errTG_PI_2;
          end
          else
            push(stack, FloatToStr(tan(a)));
        end;
        #7:
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands);
          if a = 0 then
          begin
            push(stack, '1 ');
            errors := errors or errCTG0;
          end
          else
            push(stack, FloatToStr(cotan(a)));
        end;
        #9:
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands);
          if (a < -1) or (a > 1) then
          begin
            push(stack, '1 ');
            errors := errors or errASIN;
          end
          else
            push(stack, FloatToStr(arcSin(a)));
        end;
        #11:
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands); 
          if (a < -1) or (a > 1) then
          begin
            push(stack, '1 ');
            errors := errors or errACOS;
          end
          else
            push(stack, FloatToStr(arcCos(a)));
        end;    
        #13:
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands);
          push(stack, FloatToStr(arcTan(a)));
        end;
        #15:
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands);
          push(stack, FloatToStr(arcCot(a)));
        end; 
        '!':
        begin
          strA := pop(stack).operand;
          a := operandToNumber(strA, operands); 
          if a > 10 then
          begin
            push(stack, '1 ');
            errors := errors or errFACT;
          end
          else
          begin
            temp := 1;
            for k := 1 to round(a) do
              temp := temp * k;
            push(stack, FloatToStr(temp));
          end;
        end;
      end;