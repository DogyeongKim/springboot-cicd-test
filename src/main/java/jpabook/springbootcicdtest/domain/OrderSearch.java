package jpabook.springbootcicdtest.domain;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class OrderSearch {

    private String memberName; //회원 이름
    private jpabook.springbootcicdtest.domain.OrderStatus orderStatus;//주문 상태[ORDER, CANCEL]

}