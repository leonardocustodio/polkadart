import './manta.dart' as mantabundle;

final bundle = <String, dynamic>{
  'types': <String, dynamic>{
    ...mantabundle.bundle['types'],
    'CurrencyId': {
      '_enum': ['KMA']
    },
  }
};
