package site.admin.offline;

import java.util.List;

import site.member.Member;
import site.util.Param;

public interface OfflineAdminMapper {

	List<OfflineAdmin> offlineList(Param param);

	void offlineAdd(OfflineAdmin offlineAdmin);

	List<Member> findId(OfflineAdmin offlineAdmin);

	List<OfflineAdmin> offlineSearch(OfflineAdmin offlineAdmin);
}
