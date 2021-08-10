import 'package:news_app/dto/dto.dart';

abstract class DTOMapper<D extends DTO, M> {
  M toModel(D object);
  D toDTO(M object);
}