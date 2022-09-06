import './manta.dart' as mantabundle;

final bundle = <String, dynamic>{
  'types': {
    ...mantabundle.bundle['types'],
    'CurrencyId': {
      '_enum': ['KMA']
    },
  }
};
