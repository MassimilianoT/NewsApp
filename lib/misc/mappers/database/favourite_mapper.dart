import 'package:flutter/material.dart';
import 'package:news_app/misc/mappers/database/dto_mapper.dart';
import 'package:news_app/models/favourite.dart';

class FavouriteMapper extends DTOMapper<Favourite> {
  @override
  Map<String, dynamic> toDTO(Favourite object) => {
        'id': object.id,
        'color': object.color == Colors.yellow
            ? 'yellow'
            : object.color == Colors.blue
                ? 'blue'
                : object.color == Colors.red
                    ? 'red'
                    : 'green',
      };

  @override
  Favourite toModel(Map<String, dynamic> object) {
    return Favourite(
      id: object["id"],
      color: object['color'] == 'yellow'
          ? Colors.yellow
          : object['color'] == 'blue'
              ? Colors.blue
              : object['color'] == 'red'
                  ? Colors.red
                  : Colors.green,
    );
  }
}
