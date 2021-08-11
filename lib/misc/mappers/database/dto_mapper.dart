abstract class DTOMapper<M> {
  M toModel(Map<String, dynamic> object);
  Map<String, dynamic> toDTO(M object);
}