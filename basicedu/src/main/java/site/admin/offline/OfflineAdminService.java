package site.admin.offline;

import java.util.List;

import site.member.Member;
import site.util.Param;

public interface OfflineAdminService {

	public List<OfflineAdmin> offlineList(Param param);

	public void offlineAdd(OfflineAdmin offlineAdmin);

	public List<Member> findId(OfflineAdmin offlineAdmin);

	public List<OfflineAdmin> offlineSearch(OfflineAdmin offlineAdmin);

}
