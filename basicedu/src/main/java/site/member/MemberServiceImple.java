package site.member;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import site.util.Param;

@Service("MemberService")
public class MemberServiceImple implements MemberService {

	static Logger log = LoggerFactory.getLogger(MemberServiceImple.class);

	@Autowired
	MemberMapper memberMapper;

	@Override
	public long countMember(Param param) {
		return memberMapper.countMember(param);
	}

	@Override
	public List<Member> findMemberList(Param param) {
		return memberMapper.findMemberList(param);
	}

	@Override
	public Member findMember(Member member) {
		return memberMapper.findMember(member);
	}


	@Override
	public void saveMember(Member member) {
		memberMapper.saveMember(member);
	}

	@Override
	public void modifyMember(Member member) {
		memberMapper.modifyMember(member);
	}

	@Override
	public void deleteMember(Member member) {
		memberMapper.deleteMember(member);
	}


	@Override
	public Integer nowPoint(String id) {
		// TODO Auto-generated method stub
		return memberMapper.nowPoint(id);
	}

	@Override
	public void updatePoint(Member member) {
		// TODO Auto-generated method stub
		memberMapper.updatePoint(member);
	}

	@Override
	public String passwordCheck(Member member) {
		return memberMapper.passwordCheck(member);
	}

	@Override
	public void updateAction(Member member) {
		memberMapper.updateAction(member);

	}

	@Override
	public void updateAction1(Member member) {
		memberMapper.updateAction1(member);
	}


	@Override
	public void passwordUpdate(Member member) {
		memberMapper.passwordUpdate(member);

	}

	@Override
	public Member memberInfo(String id) {
		return memberMapper.memberInfo(id);
	}


	@Override
	public List<Member> selectMember() {
		// TODO Auto-generated method stub
		return memberMapper.selectMember();
	}

	@Override
	public Member findMemberOne(String id) {
		// TODO Auto-generated method stub
		return memberMapper.findMemberOne(id);
	}

	@Override
	public String findLecturerImg(String id) {
		// TODO Auto-generated method stub
		return memberMapper.findLecturerImg(id);
	}















}
