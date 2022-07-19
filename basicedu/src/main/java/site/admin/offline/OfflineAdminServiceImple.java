package site.admin.offline;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import site.member.Member;
import site.mypage.lecturer.offline.OfflineServiceImple;
import site.util.Param;

@Service("OfflineAdminService")
public class OfflineAdminServiceImple implements OfflineAdminService{
	static Logger log = LoggerFactory.getLogger(OfflineServiceImple.class);

	@Autowired
	OfflineAdminMapper offlineadminMapper;

	@Override
	public List<OfflineAdmin> offlineList(Param param) {
		return offlineadminMapper.offlineList(param);
	}

	@Override
	public void offlineAdd(OfflineAdmin offlineAdmin) {
		offlineadminMapper.offlineAdd(offlineAdmin);

	}

	@Override
	public List<Member> findId(OfflineAdmin offlineAdmin) {
		return offlineadminMapper.findId(offlineAdmin);
	}

	@Override
	public List<OfflineAdmin> offlineSearch(OfflineAdmin offlineAdmin) {
		return offlineadminMapper.offlineSearch(offlineAdmin);
	}

}
