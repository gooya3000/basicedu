package site.member;

import java.util.List;

import site.util.Param;

public interface MemberService {

	public long countMember(Param param);

	public List<Member> findMemberList(Param param);

	public Member findMember(Member member);

	public void saveMember(Member member);

	public void modifyMember(Member member);

	public void deleteMember(Member member);

	public Integer nowPoint(String id);

	public void updatePoint(Member member);

	public String passwordCheck(Member member);

	public void updateAction(Member member);

	public void updateAction1(Member member);

	public void passwordUpdate(Member member);

	public Member memberInfo(String id);

	public List<Member> selectMember();

	public Member findMemberOne(String id);

	public String findLecturerImg(String id);
}
