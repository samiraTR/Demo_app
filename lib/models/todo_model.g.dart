// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoAdapter extends TypeAdapter<ToDo> {
  @override
  final int typeId = 0;

  @override
  ToDo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDo(
      id: fields[0] as int,
      lat: fields[1] as String,
      long: fields[2] as String,
      address: fields[3] as String,
      title: fields[4] as String,
      text: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ToDo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.long)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
