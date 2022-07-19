package site.member;

import java.util.List;

import site.util.Param;

public interface MemberMapper {

	long countMember(Param param);

	List<Member> findMemberList(Param param);

	Member findMember(Member member);

	void saveMember(Member member);

	void modifyMember(Member member);

	void deleteMember(Member member);

	Integer nowPoint(String id);

	void updatePoint(Member member);

	String passwordCheck(Member member);

	void updateAction(Member member);

	void updateAction1(Member member);

	void passwordUpdate(Member member);

	Member memberInfo(String id);

	List<Member> selectMember();

	Member findMemberOne(String id);

	String findLecturerImg(String id);
}
