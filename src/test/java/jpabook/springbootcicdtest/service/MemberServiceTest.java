package jpabook.springbootcicdtest.service;
//
//import static org.junit.jupiter.api.Assertions.*;
//
//import jpabook.springbootcicdtest.domain.Member;
//import jpabook.springbootcicdtest.repository.MemberRepository;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.test.context.junit4.SpringRunner;
//import org.springframework.transaction.annotation.Transactional;
//import static org.junit.Assert.assertEquals;
//import static org.junit.Assert.fail;
//
//@RunWith(SpringRunner.class) //스프링과 테스트 통합
//@SpringBootTest // 스프링 부트 띄우고 테스트(이게 없으면 @Autowired 다 실패)
//@Transactional
public class MemberServiceTest {
//
//    @Autowired MemberService memberService;
//    @Autowired MemberRepository memberRepository;
//
//    @Test
//    public void 회원가입() throws Exception {
//        //Given
//        Member member = new Member();
//        member.setName("kim");
//
//        //When
//        Long saveId = memberService.join(member);
//
//        //Then
//        assertEquals(member, memberRepository.findOne(saveId));
//    }
//
//    @Test(expected = IllegalStateException.class)
//    public void 중복_회원_예외() throws Exception {
//        //Given
//        Member member1 = new Member();
//        member1.setName("kim");
//
//        Member member2 = new Member();
//        member2.setName("kim");
//
//        //When
//        memberService.join(member1);
//        memberService.join(member2); //예외가 발생해야 한다.
//
//        //Then
//        fail("예외가 발생해야 한다.");
//    }
}