import 'package:demo/components/pageList/page_interface.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PageDataSource<T> implements PageInterface {
  /* 页码 */
  int page = 1;
  /* 是否更多 */
  bool hasMore = true;
  /* 每页数据量 */
  int size = 20;
  /* 列表数据 */
  List<T> list = [];
  /* 刷新加载 */
  RefreshController refreshController = RefreshController();

  @override
  void onRefresh() async {
    // TODO: implement _onRefresh
    page = 1;
    loadPageData();
  }

  @override
  void onLoadMore() async {
    // TODO: implement _onLoadMore
    if (hasMore) {
      loadPageData();
    }
  }

  @override
  void loadPageData() async {
    // TODO: implement _loadPageData
  }

  void addList(List<T> list, int page, int total, Function setState) {
    var tempList = this.list;
    if (this.page == 1) {
      tempList = [];
    }

    tempList.addAll(list);

    // 有时会出现数量异常，这里加入新返回列表不为空判断
    hasMore = (tempList.length < total) && list.isNotEmpty;

    if (hasMore) {
      page += 1;
    }
    this.page = page;

    setState((){
      this.list = tempList;
    });

    this.endRefreshing();
  }


  /* 结束刷新/加载  status 成功/失败 */
  void endRefreshing({bool status = true}) async {
    if (status) {
      if (refreshController.isRefresh) {
        refreshController.refreshCompleted(resetFooterState: true);
      }
      if (refreshController.isLoading) {
        if (hasMore) {
          refreshController.loadComplete();
        } else {
          refreshController.loadNoData();
        }
      }
    } else {
      if (refreshController.isRefresh) {
        refreshController.refreshFailed();
      }
      if (refreshController.isLoading) {
        refreshController.loadFailed();
      }
    }
  }
}