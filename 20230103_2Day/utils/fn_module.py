#!/usr/bin/env python
# coding: utf-8

# # 모듈 만들기

# In[ ]:


class Use_Util :
    # 생성자 만들기 : 앞 뒤로 __ 넣어야 한다 (규칙!)
    # 값을 미리 정의 할 거야? 
    def __init__(self,p_a,p_b) :
        # 멤버 변수 정의 하기 
        # self.~ : 멤버 
        # 동일 클래스 안에서 언제든 호출 해서 사용이 가능
        # a : 전달받은 값 
        # self.a : 클래스 내의 매개 변수 
        self.a = p_a
        self.b = p_b
    
    def getPlus(self) : 
        return self.a + self.b
    
    

