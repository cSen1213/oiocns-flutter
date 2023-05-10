import 'dart:io';

import 'package:orginone/dart/base/model.dart';
import 'package:orginone/dart/core/market/model.dart';

import 'filesysItem.dart';

//分片大小
const chunkSize = 1024 * 1024;

//可为空的进度回调
typedef OnProgressType = void Function(double);

//文件系统目录接口
abstract class IFileSystemItem {
  //文件系统
  late IFileSystem filesys;

  //文件系统项对应的目标
  late FileItemModel metadata;

  //上级文件系统项
  IFileSystemItem? parent;

  //下级文件系统项数组
  late List<IFileSystemItem> children;

  //分享信息
  FileItemShare shareInfo();

  //创建文件系统项（目录）
  Future<IFileSystemItem?> create(String name);

  //删除文件系统项
  Future<bool> delete();

  //重命名
  Future<bool> rename(String name);

  //拷贝文件系统项（目录）
  Future<bool> copy(IFileSystemItem destination);

  //移动文件系统项（目录）
  Future<bool> move(IFileSystemItem destination);

  //加载下级文件系统项数组
  Future<bool> loadChildren([bool reload = false]);

  //上传文件
  Future<IFileSystemItem?> upload(String name, File file,
      [OnProgressType? onProgress]);
  //下载文件
  Future<void> download(String path, OnProgressType onProgress);
}

class FileSystemItem implements IFileSystemItem {
  FileSystemItem(this.filesys, this.metadata, [this.parent]) {
    children = [];
    belongId = filesys.metadata.belongId;
  }

  @override
  late List<IFileSystemItem> children;

  late String belongId;

  @override
  IFileSystem filesys;

  @override
  FileItemModel metadata;

  @override
  IFileSystemItem? parent;

  @override
  Future<bool> copy(IFileSystemItem destination) {
    // TODO: implement copy
    throw UnimplementedError();
  }

  @override
  Future<IFileSystemItem?> create(String name) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> download(String path, OnProgressType onProgress) {
    // TODO: implement download
    throw UnimplementedError();
  }

  @override
  Future<bool> loadChildren([bool reload = false]) {
    // TODO: implement loadChildren
    throw UnimplementedError();
  }

  @override
  Future<bool> move(IFileSystemItem destination) {
    // TODO: implement move
    throw UnimplementedError();
  }

  @override
  Future<bool> rename(String name) async {
    if (metadata.name != name && !(await _findByName(name))) {
      final res = await kernel.anystore.bucketOpreate<FileItemModel>(
          belongId,
          BucketOpreateModel(
            name: name,
            key: _formatKey(),
            operate: BucketOpreates.rename,
          ));
      if (res.success && res.data != null) {
        metadata = res.data!;
        return true;
      }
    }
    return false;
  }

  @override
  FileItemShare shareInfo() {
    // TODO: implement shareInfo
    throw UnimplementedError();
  }

  @override
  Future<IFileSystemItem?> upload(String name, File file,
      [OnProgressType? onProgress]) {
    // TODO: implement upload
    throw UnimplementedError();
  }

  List<FileItemModel> get childrenData {
    return children.map((item) {
      return item.metadata;
    }).toList();
  }
}