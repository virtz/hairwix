// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class Product_Adapter extends TypeAdapter<Product_> {
      @override
  int get typeId => 0;
  @override
  Product_ read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product_(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      owner: fields[3] as String,
      category: fields[4] as String,
      cropImage: fields[5] as String,
      banner1: fields[6] as String,
      banner2: fields[7] as String,
      price: fields[8] as int,
      status: fields[9] as String,
      pricetype: fields[10] as String,
      quantity: fields[11] as int,
      totalPrice: fields[12] as double,
      referenceId: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product_ obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.owner)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.cropImage)
      ..writeByte(6)
      ..write(obj.banner1)
      ..writeByte(7)
      ..write(obj.banner2)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.pricetype)
      ..writeByte(11)
      ..write(obj.quantity)
      ..writeByte(12)
      ..write(obj.totalPrice)
      ..writeByte(13)
      ..write(obj.referenceId);
  }
}
