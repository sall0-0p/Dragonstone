return function(mainFrame, p1, p2, p3, p4, p5)
   
    mainFrame:onEvent(function(self, event) 
        if event == "8495532365" then
            os.queueEvent("6771818008", mainFrame, p1, p2, p3, p4, p5)
        end
    end)
    
end