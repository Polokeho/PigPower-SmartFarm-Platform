// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FarmersTable extends Farmers with TableInfo<$FarmersTable, Farmer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FarmersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _farmerNumberMeta = const VerificationMeta(
    'farmerNumber',
  );
  @override
  late final GeneratedColumn<String> farmerNumber = GeneratedColumn<String>(
    'farmer_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _districtCodeMeta = const VerificationMeta(
    'districtCode',
  );
  @override
  late final GeneratedColumn<String> districtCode = GeneratedColumn<String>(
    'district_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _communityMeta = const VerificationMeta(
    'community',
  );
  @override
  late final GeneratedColumn<String> community = GeneratedColumn<String>(
    'community',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PROSPECT'),
  );
  static const VerificationMeta _documentationCompleteMeta =
      const VerificationMeta('documentationComplete');
  @override
  late final GeneratedColumn<bool> documentationComplete =
      GeneratedColumn<bool>(
        'documentation_complete',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("documentation_complete" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('SYNCED'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    farmerNumber,
    name,
    districtCode,
    community,
    phone,
    status,
    documentationComplete,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'farmers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Farmer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('farmer_number')) {
      context.handle(
        _farmerNumberMeta,
        farmerNumber.isAcceptableOrUnknown(
          data['farmer_number']!,
          _farmerNumberMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('district_code')) {
      context.handle(
        _districtCodeMeta,
        districtCode.isAcceptableOrUnknown(
          data['district_code']!,
          _districtCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_districtCodeMeta);
    }
    if (data.containsKey('community')) {
      context.handle(
        _communityMeta,
        community.isAcceptableOrUnknown(data['community']!, _communityMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('documentation_complete')) {
      context.handle(
        _documentationCompleteMeta,
        documentationComplete.isAcceptableOrUnknown(
          data['documentation_complete']!,
          _documentationCompleteMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Farmer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Farmer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      farmerNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farmer_number'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      districtCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}district_code'],
      )!,
      community: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}community'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      documentationComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}documentation_complete'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $FarmersTable createAlias(String alias) {
    return $FarmersTable(attachedDatabase, alias);
  }
}

class Farmer extends DataClass implements Insertable<Farmer> {
  /// Local-only UUID, always present. For offline-created rows this IS
  /// the client_id sent to the server; once confirmed, [serverId] is
  /// populated too — OSDS FR-OSDS-006/007/025.
  final String id;
  final String? serverId;
  final String? farmerNumber;
  final String name;
  final String districtCode;
  final String? community;
  final String? phone;
  final String status;
  final bool documentationComplete;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// PENDING_SYNC | SYNCING | SYNCED | REJECTED — mirrors the outbox
  /// item's status for THIS record specifically, so the UI can show a
  /// per-row sync badge without joining against the outbox table.
  final String syncStatus;
  const Farmer({
    required this.id,
    this.serverId,
    this.farmerNumber,
    required this.name,
    required this.districtCode,
    this.community,
    this.phone,
    required this.status,
    required this.documentationComplete,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    if (!nullToAbsent || farmerNumber != null) {
      map['farmer_number'] = Variable<String>(farmerNumber);
    }
    map['name'] = Variable<String>(name);
    map['district_code'] = Variable<String>(districtCode);
    if (!nullToAbsent || community != null) {
      map['community'] = Variable<String>(community);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['status'] = Variable<String>(status);
    map['documentation_complete'] = Variable<bool>(documentationComplete);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  FarmersCompanion toCompanion(bool nullToAbsent) {
    return FarmersCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      farmerNumber: farmerNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(farmerNumber),
      name: Value(name),
      districtCode: Value(districtCode),
      community: community == null && nullToAbsent
          ? const Value.absent()
          : Value(community),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      status: Value(status),
      documentationComplete: Value(documentationComplete),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory Farmer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Farmer(
      id: serializer.fromJson<String>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      farmerNumber: serializer.fromJson<String?>(json['farmerNumber']),
      name: serializer.fromJson<String>(json['name']),
      districtCode: serializer.fromJson<String>(json['districtCode']),
      community: serializer.fromJson<String?>(json['community']),
      phone: serializer.fromJson<String?>(json['phone']),
      status: serializer.fromJson<String>(json['status']),
      documentationComplete: serializer.fromJson<bool>(
        json['documentationComplete'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'farmerNumber': serializer.toJson<String?>(farmerNumber),
      'name': serializer.toJson<String>(name),
      'districtCode': serializer.toJson<String>(districtCode),
      'community': serializer.toJson<String?>(community),
      'phone': serializer.toJson<String?>(phone),
      'status': serializer.toJson<String>(status),
      'documentationComplete': serializer.toJson<bool>(documentationComplete),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  Farmer copyWith({
    String? id,
    Value<String?> serverId = const Value.absent(),
    Value<String?> farmerNumber = const Value.absent(),
    String? name,
    String? districtCode,
    Value<String?> community = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    String? status,
    bool? documentationComplete,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) => Farmer(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    farmerNumber: farmerNumber.present ? farmerNumber.value : this.farmerNumber,
    name: name ?? this.name,
    districtCode: districtCode ?? this.districtCode,
    community: community.present ? community.value : this.community,
    phone: phone.present ? phone.value : this.phone,
    status: status ?? this.status,
    documentationComplete: documentationComplete ?? this.documentationComplete,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  Farmer copyWithCompanion(FarmersCompanion data) {
    return Farmer(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      farmerNumber: data.farmerNumber.present
          ? data.farmerNumber.value
          : this.farmerNumber,
      name: data.name.present ? data.name.value : this.name,
      districtCode: data.districtCode.present
          ? data.districtCode.value
          : this.districtCode,
      community: data.community.present ? data.community.value : this.community,
      phone: data.phone.present ? data.phone.value : this.phone,
      status: data.status.present ? data.status.value : this.status,
      documentationComplete: data.documentationComplete.present
          ? data.documentationComplete.value
          : this.documentationComplete,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Farmer(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('farmerNumber: $farmerNumber, ')
          ..write('name: $name, ')
          ..write('districtCode: $districtCode, ')
          ..write('community: $community, ')
          ..write('phone: $phone, ')
          ..write('status: $status, ')
          ..write('documentationComplete: $documentationComplete, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    farmerNumber,
    name,
    districtCode,
    community,
    phone,
    status,
    documentationComplete,
    createdAt,
    updatedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Farmer &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.farmerNumber == this.farmerNumber &&
          other.name == this.name &&
          other.districtCode == this.districtCode &&
          other.community == this.community &&
          other.phone == this.phone &&
          other.status == this.status &&
          other.documentationComplete == this.documentationComplete &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class FarmersCompanion extends UpdateCompanion<Farmer> {
  final Value<String> id;
  final Value<String?> serverId;
  final Value<String?> farmerNumber;
  final Value<String> name;
  final Value<String> districtCode;
  final Value<String?> community;
  final Value<String?> phone;
  final Value<String> status;
  final Value<bool> documentationComplete;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const FarmersCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.farmerNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.districtCode = const Value.absent(),
    this.community = const Value.absent(),
    this.phone = const Value.absent(),
    this.status = const Value.absent(),
    this.documentationComplete = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FarmersCompanion.insert({
    required String id,
    this.serverId = const Value.absent(),
    this.farmerNumber = const Value.absent(),
    required String name,
    required String districtCode,
    this.community = const Value.absent(),
    this.phone = const Value.absent(),
    this.status = const Value.absent(),
    this.documentationComplete = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       districtCode = Value(districtCode),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Farmer> custom({
    Expression<String>? id,
    Expression<String>? serverId,
    Expression<String>? farmerNumber,
    Expression<String>? name,
    Expression<String>? districtCode,
    Expression<String>? community,
    Expression<String>? phone,
    Expression<String>? status,
    Expression<bool>? documentationComplete,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (farmerNumber != null) 'farmer_number': farmerNumber,
      if (name != null) 'name': name,
      if (districtCode != null) 'district_code': districtCode,
      if (community != null) 'community': community,
      if (phone != null) 'phone': phone,
      if (status != null) 'status': status,
      if (documentationComplete != null)
        'documentation_complete': documentationComplete,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FarmersCompanion copyWith({
    Value<String>? id,
    Value<String?>? serverId,
    Value<String?>? farmerNumber,
    Value<String>? name,
    Value<String>? districtCode,
    Value<String?>? community,
    Value<String?>? phone,
    Value<String>? status,
    Value<bool>? documentationComplete,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return FarmersCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      farmerNumber: farmerNumber ?? this.farmerNumber,
      name: name ?? this.name,
      districtCode: districtCode ?? this.districtCode,
      community: community ?? this.community,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      documentationComplete:
          documentationComplete ?? this.documentationComplete,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (farmerNumber.present) {
      map['farmer_number'] = Variable<String>(farmerNumber.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (districtCode.present) {
      map['district_code'] = Variable<String>(districtCode.value);
    }
    if (community.present) {
      map['community'] = Variable<String>(community.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (documentationComplete.present) {
      map['documentation_complete'] = Variable<bool>(
        documentationComplete.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FarmersCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('farmerNumber: $farmerNumber, ')
          ..write('name: $name, ')
          ..write('districtCode: $districtCode, ')
          ..write('community: $community, ')
          ..write('phone: $phone, ')
          ..write('status: $status, ')
          ..write('documentationComplete: $documentationComplete, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductionBatchesTable extends ProductionBatches
    with TableInfo<$ProductionBatchesTable, ProductionBatche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductionBatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _batchNumberMeta = const VerificationMeta(
    'batchNumber',
  );
  @override
  late final GeneratedColumn<String> batchNumber = GeneratedColumn<String>(
    'batch_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<String> farmId = GeneratedColumn<String>(
    'farm_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pigIdsJsonMeta = const VerificationMeta(
    'pigIdsJson',
  );
  @override
  late final GeneratedColumn<String> pigIdsJson = GeneratedColumn<String>(
    'pig_ids_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('RECORDED'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PENDING_SYNC'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    batchNumber,
    farmId,
    pigIdsJson,
    weightKg,
    recordedAt,
    notes,
    status,
    createdAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'production_batches';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductionBatche> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('batch_number')) {
      context.handle(
        _batchNumberMeta,
        batchNumber.isAcceptableOrUnknown(
          data['batch_number']!,
          _batchNumberMeta,
        ),
      );
    }
    if (data.containsKey('farm_id')) {
      context.handle(
        _farmIdMeta,
        farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta),
      );
    } else if (isInserting) {
      context.missing(_farmIdMeta);
    }
    if (data.containsKey('pig_ids_json')) {
      context.handle(
        _pigIdsJsonMeta,
        pigIdsJson.isAcceptableOrUnknown(
          data['pig_ids_json']!,
          _pigIdsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pigIdsJsonMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductionBatche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductionBatche(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      batchNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_number'],
      ),
      farmId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm_id'],
      )!,
      pigIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pig_ids_json'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $ProductionBatchesTable createAlias(String alias) {
    return $ProductionBatchesTable(attachedDatabase, alias);
  }
}

class ProductionBatche extends DataClass
    implements Insertable<ProductionBatche> {
  final String id;
  final String? serverId;
  final String? batchNumber;
  final String farmId;
  final String pigIdsJson;
  final double? weightKg;
  final DateTime recordedAt;
  final String? notes;
  final String status;
  final DateTime createdAt;
  final String syncStatus;
  const ProductionBatche({
    required this.id,
    this.serverId,
    this.batchNumber,
    required this.farmId,
    required this.pigIdsJson,
    this.weightKg,
    required this.recordedAt,
    this.notes,
    required this.status,
    required this.createdAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    if (!nullToAbsent || batchNumber != null) {
      map['batch_number'] = Variable<String>(batchNumber);
    }
    map['farm_id'] = Variable<String>(farmId);
    map['pig_ids_json'] = Variable<String>(pigIdsJson);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  ProductionBatchesCompanion toCompanion(bool nullToAbsent) {
    return ProductionBatchesCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      batchNumber: batchNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(batchNumber),
      farmId: Value(farmId),
      pigIdsJson: Value(pigIdsJson),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      recordedAt: Value(recordedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory ProductionBatche.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductionBatche(
      id: serializer.fromJson<String>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      batchNumber: serializer.fromJson<String?>(json['batchNumber']),
      farmId: serializer.fromJson<String>(json['farmId']),
      pigIdsJson: serializer.fromJson<String>(json['pigIdsJson']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'batchNumber': serializer.toJson<String?>(batchNumber),
      'farmId': serializer.toJson<String>(farmId),
      'pigIdsJson': serializer.toJson<String>(pigIdsJson),
      'weightKg': serializer.toJson<double?>(weightKg),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  ProductionBatche copyWith({
    String? id,
    Value<String?> serverId = const Value.absent(),
    Value<String?> batchNumber = const Value.absent(),
    String? farmId,
    String? pigIdsJson,
    Value<double?> weightKg = const Value.absent(),
    DateTime? recordedAt,
    Value<String?> notes = const Value.absent(),
    String? status,
    DateTime? createdAt,
    String? syncStatus,
  }) => ProductionBatche(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    batchNumber: batchNumber.present ? batchNumber.value : this.batchNumber,
    farmId: farmId ?? this.farmId,
    pigIdsJson: pigIdsJson ?? this.pigIdsJson,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    recordedAt: recordedAt ?? this.recordedAt,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  ProductionBatche copyWithCompanion(ProductionBatchesCompanion data) {
    return ProductionBatche(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      batchNumber: data.batchNumber.present
          ? data.batchNumber.value
          : this.batchNumber,
      farmId: data.farmId.present ? data.farmId.value : this.farmId,
      pigIdsJson: data.pigIdsJson.present
          ? data.pigIdsJson.value
          : this.pigIdsJson,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductionBatche(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('farmId: $farmId, ')
          ..write('pigIdsJson: $pigIdsJson, ')
          ..write('weightKg: $weightKg, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    batchNumber,
    farmId,
    pigIdsJson,
    weightKg,
    recordedAt,
    notes,
    status,
    createdAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductionBatche &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.batchNumber == this.batchNumber &&
          other.farmId == this.farmId &&
          other.pigIdsJson == this.pigIdsJson &&
          other.weightKg == this.weightKg &&
          other.recordedAt == this.recordedAt &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class ProductionBatchesCompanion extends UpdateCompanion<ProductionBatche> {
  final Value<String> id;
  final Value<String?> serverId;
  final Value<String?> batchNumber;
  final Value<String> farmId;
  final Value<String> pigIdsJson;
  final Value<double?> weightKg;
  final Value<DateTime> recordedAt;
  final Value<String?> notes;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const ProductionBatchesCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.farmId = const Value.absent(),
    this.pigIdsJson = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductionBatchesCompanion.insert({
    required String id,
    this.serverId = const Value.absent(),
    this.batchNumber = const Value.absent(),
    required String farmId,
    required String pigIdsJson,
    this.weightKg = const Value.absent(),
    required DateTime recordedAt,
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       farmId = Value(farmId),
       pigIdsJson = Value(pigIdsJson),
       recordedAt = Value(recordedAt),
       createdAt = Value(createdAt);
  static Insertable<ProductionBatche> custom({
    Expression<String>? id,
    Expression<String>? serverId,
    Expression<String>? batchNumber,
    Expression<String>? farmId,
    Expression<String>? pigIdsJson,
    Expression<double>? weightKg,
    Expression<DateTime>? recordedAt,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (batchNumber != null) 'batch_number': batchNumber,
      if (farmId != null) 'farm_id': farmId,
      if (pigIdsJson != null) 'pig_ids_json': pigIdsJson,
      if (weightKg != null) 'weight_kg': weightKg,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductionBatchesCompanion copyWith({
    Value<String>? id,
    Value<String?>? serverId,
    Value<String?>? batchNumber,
    Value<String>? farmId,
    Value<String>? pigIdsJson,
    Value<double?>? weightKg,
    Value<DateTime>? recordedAt,
    Value<String?>? notes,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return ProductionBatchesCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      batchNumber: batchNumber ?? this.batchNumber,
      farmId: farmId ?? this.farmId,
      pigIdsJson: pigIdsJson ?? this.pigIdsJson,
      weightKg: weightKg ?? this.weightKg,
      recordedAt: recordedAt ?? this.recordedAt,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (batchNumber.present) {
      map['batch_number'] = Variable<String>(batchNumber.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<String>(farmId.value);
    }
    if (pigIdsJson.present) {
      map['pig_ids_json'] = Variable<String>(pigIdsJson.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductionBatchesCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('farmId: $farmId, ')
          ..write('pigIdsJson: $pigIdsJson, ')
          ..write('weightKg: $weightKg, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VeterinaryRecordsTable extends VeterinaryRecords
    with TableInfo<$VeterinaryRecordsTable, VeterinaryRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VeterinaryRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordNumberMeta = const VerificationMeta(
    'recordNumber',
  );
  @override
  late final GeneratedColumn<String> recordNumber = GeneratedColumn<String>(
    'record_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pigIdMeta = const VerificationMeta('pigId');
  @override
  late final GeneratedColumn<String> pigId = GeneratedColumn<String>(
    'pig_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vaccineTypeCodeMeta = const VerificationMeta(
    'vaccineTypeCode',
  );
  @override
  late final GeneratedColumn<String> vaccineTypeCode = GeneratedColumn<String>(
    'vaccine_type_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _administeredAtMeta = const VerificationMeta(
    'administeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> administeredAt =
      GeneratedColumn<DateTime>(
        'administered_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('PENDING_SYNC'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    recordNumber,
    pigId,
    type,
    vaccineTypeCode,
    administeredAt,
    notes,
    createdAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'veterinary_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<VeterinaryRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('record_number')) {
      context.handle(
        _recordNumberMeta,
        recordNumber.isAcceptableOrUnknown(
          data['record_number']!,
          _recordNumberMeta,
        ),
      );
    }
    if (data.containsKey('pig_id')) {
      context.handle(
        _pigIdMeta,
        pigId.isAcceptableOrUnknown(data['pig_id']!, _pigIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pigIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('vaccine_type_code')) {
      context.handle(
        _vaccineTypeCodeMeta,
        vaccineTypeCode.isAcceptableOrUnknown(
          data['vaccine_type_code']!,
          _vaccineTypeCodeMeta,
        ),
      );
    }
    if (data.containsKey('administered_at')) {
      context.handle(
        _administeredAtMeta,
        administeredAt.isAcceptableOrUnknown(
          data['administered_at']!,
          _administeredAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_administeredAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VeterinaryRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VeterinaryRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      recordNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_number'],
      ),
      pigId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pig_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      vaccineTypeCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vaccine_type_code'],
      ),
      administeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}administered_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $VeterinaryRecordsTable createAlias(String alias) {
    return $VeterinaryRecordsTable(attachedDatabase, alias);
  }
}

class VeterinaryRecord extends DataClass
    implements Insertable<VeterinaryRecord> {
  final String id;
  final String? serverId;
  final String? recordNumber;
  final String pigId;
  final String type;
  final String? vaccineTypeCode;
  final DateTime administeredAt;
  final String? notes;
  final DateTime createdAt;
  final String syncStatus;
  const VeterinaryRecord({
    required this.id,
    this.serverId,
    this.recordNumber,
    required this.pigId,
    required this.type,
    this.vaccineTypeCode,
    required this.administeredAt,
    this.notes,
    required this.createdAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    if (!nullToAbsent || recordNumber != null) {
      map['record_number'] = Variable<String>(recordNumber);
    }
    map['pig_id'] = Variable<String>(pigId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || vaccineTypeCode != null) {
      map['vaccine_type_code'] = Variable<String>(vaccineTypeCode);
    }
    map['administered_at'] = Variable<DateTime>(administeredAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  VeterinaryRecordsCompanion toCompanion(bool nullToAbsent) {
    return VeterinaryRecordsCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      recordNumber: recordNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(recordNumber),
      pigId: Value(pigId),
      type: Value(type),
      vaccineTypeCode: vaccineTypeCode == null && nullToAbsent
          ? const Value.absent()
          : Value(vaccineTypeCode),
      administeredAt: Value(administeredAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory VeterinaryRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VeterinaryRecord(
      id: serializer.fromJson<String>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      recordNumber: serializer.fromJson<String?>(json['recordNumber']),
      pigId: serializer.fromJson<String>(json['pigId']),
      type: serializer.fromJson<String>(json['type']),
      vaccineTypeCode: serializer.fromJson<String?>(json['vaccineTypeCode']),
      administeredAt: serializer.fromJson<DateTime>(json['administeredAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'recordNumber': serializer.toJson<String?>(recordNumber),
      'pigId': serializer.toJson<String>(pigId),
      'type': serializer.toJson<String>(type),
      'vaccineTypeCode': serializer.toJson<String?>(vaccineTypeCode),
      'administeredAt': serializer.toJson<DateTime>(administeredAt),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  VeterinaryRecord copyWith({
    String? id,
    Value<String?> serverId = const Value.absent(),
    Value<String?> recordNumber = const Value.absent(),
    String? pigId,
    String? type,
    Value<String?> vaccineTypeCode = const Value.absent(),
    DateTime? administeredAt,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    String? syncStatus,
  }) => VeterinaryRecord(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    recordNumber: recordNumber.present ? recordNumber.value : this.recordNumber,
    pigId: pigId ?? this.pigId,
    type: type ?? this.type,
    vaccineTypeCode: vaccineTypeCode.present
        ? vaccineTypeCode.value
        : this.vaccineTypeCode,
    administeredAt: administeredAt ?? this.administeredAt,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  VeterinaryRecord copyWithCompanion(VeterinaryRecordsCompanion data) {
    return VeterinaryRecord(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      recordNumber: data.recordNumber.present
          ? data.recordNumber.value
          : this.recordNumber,
      pigId: data.pigId.present ? data.pigId.value : this.pigId,
      type: data.type.present ? data.type.value : this.type,
      vaccineTypeCode: data.vaccineTypeCode.present
          ? data.vaccineTypeCode.value
          : this.vaccineTypeCode,
      administeredAt: data.administeredAt.present
          ? data.administeredAt.value
          : this.administeredAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VeterinaryRecord(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('recordNumber: $recordNumber, ')
          ..write('pigId: $pigId, ')
          ..write('type: $type, ')
          ..write('vaccineTypeCode: $vaccineTypeCode, ')
          ..write('administeredAt: $administeredAt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    recordNumber,
    pigId,
    type,
    vaccineTypeCode,
    administeredAt,
    notes,
    createdAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VeterinaryRecord &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.recordNumber == this.recordNumber &&
          other.pigId == this.pigId &&
          other.type == this.type &&
          other.vaccineTypeCode == this.vaccineTypeCode &&
          other.administeredAt == this.administeredAt &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class VeterinaryRecordsCompanion extends UpdateCompanion<VeterinaryRecord> {
  final Value<String> id;
  final Value<String?> serverId;
  final Value<String?> recordNumber;
  final Value<String> pigId;
  final Value<String> type;
  final Value<String?> vaccineTypeCode;
  final Value<DateTime> administeredAt;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const VeterinaryRecordsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.recordNumber = const Value.absent(),
    this.pigId = const Value.absent(),
    this.type = const Value.absent(),
    this.vaccineTypeCode = const Value.absent(),
    this.administeredAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VeterinaryRecordsCompanion.insert({
    required String id,
    this.serverId = const Value.absent(),
    this.recordNumber = const Value.absent(),
    required String pigId,
    required String type,
    this.vaccineTypeCode = const Value.absent(),
    required DateTime administeredAt,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pigId = Value(pigId),
       type = Value(type),
       administeredAt = Value(administeredAt),
       createdAt = Value(createdAt);
  static Insertable<VeterinaryRecord> custom({
    Expression<String>? id,
    Expression<String>? serverId,
    Expression<String>? recordNumber,
    Expression<String>? pigId,
    Expression<String>? type,
    Expression<String>? vaccineTypeCode,
    Expression<DateTime>? administeredAt,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (recordNumber != null) 'record_number': recordNumber,
      if (pigId != null) 'pig_id': pigId,
      if (type != null) 'type': type,
      if (vaccineTypeCode != null) 'vaccine_type_code': vaccineTypeCode,
      if (administeredAt != null) 'administered_at': administeredAt,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VeterinaryRecordsCompanion copyWith({
    Value<String>? id,
    Value<String?>? serverId,
    Value<String?>? recordNumber,
    Value<String>? pigId,
    Value<String>? type,
    Value<String?>? vaccineTypeCode,
    Value<DateTime>? administeredAt,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return VeterinaryRecordsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      recordNumber: recordNumber ?? this.recordNumber,
      pigId: pigId ?? this.pigId,
      type: type ?? this.type,
      vaccineTypeCode: vaccineTypeCode ?? this.vaccineTypeCode,
      administeredAt: administeredAt ?? this.administeredAt,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (recordNumber.present) {
      map['record_number'] = Variable<String>(recordNumber.value);
    }
    if (pigId.present) {
      map['pig_id'] = Variable<String>(pigId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (vaccineTypeCode.present) {
      map['vaccine_type_code'] = Variable<String>(vaccineTypeCode.value);
    }
    if (administeredAt.present) {
      map['administered_at'] = Variable<DateTime>(administeredAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VeterinaryRecordsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('recordNumber: $recordNumber, ')
          ..write('pigId: $pigId, ')
          ..write('type: $type, ')
          ..write('vaccineTypeCode: $vaccineTypeCode, ')
          ..write('administeredAt: $administeredAt, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutboxItemsTable extends OutboxItems
    with TableInfo<$OutboxItemsTable, OutboxItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityTierMeta = const VerificationMeta(
    'priorityTier',
  );
  @override
  late final GeneratedColumn<int> priorityTier = GeneratedColumn<int>(
    'priority_tier',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('QUEUED'),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    clientId,
    idempotencyKey,
    payloadJson,
    priorityTier,
    status,
    retryCount,
    createdAt,
    lastAttemptAt,
    errorMessage,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<OutboxItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('priority_tier')) {
      context.handle(
        _priorityTierMeta,
        priorityTier.isAcceptableOrUnknown(
          data['priority_tier']!,
          _priorityTierMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OutboxItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      priorityTier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority_tier'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
    );
  }

  @override
  $OutboxItemsTable createAlias(String alias) {
    return $OutboxItemsTable(attachedDatabase, alias);
  }
}

class OutboxItem extends DataClass implements Insertable<OutboxItem> {
  final int id;
  final String entityType;
  final String clientId;
  final String idempotencyKey;
  final String payloadJson;

  /// TIER_1 (vet emergencies) .. TIER_5 (reference data) — OSDS §10.
  final int priorityTier;

  /// CREATED | QUEUED | UPLOADING | SERVER_VALIDATING | CONFIRMED | REJECTED
  /// — OSDS §8/§10 lifecycle.
  final String status;
  final int retryCount;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  final String? errorMessage;
  const OutboxItem({
    required this.id,
    required this.entityType,
    required this.clientId,
    required this.idempotencyKey,
    required this.payloadJson,
    required this.priorityTier,
    required this.status,
    required this.retryCount,
    required this.createdAt,
    this.lastAttemptAt,
    this.errorMessage,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['client_id'] = Variable<String>(clientId);
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    map['payload_json'] = Variable<String>(payloadJson);
    map['priority_tier'] = Variable<int>(priorityTier);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    return map;
  }

  OutboxItemsCompanion toCompanion(bool nullToAbsent) {
    return OutboxItemsCompanion(
      id: Value(id),
      entityType: Value(entityType),
      clientId: Value(clientId),
      idempotencyKey: Value(idempotencyKey),
      payloadJson: Value(payloadJson),
      priorityTier: Value(priorityTier),
      status: Value(status),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
    );
  }

  factory OutboxItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxItem(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      clientId: serializer.fromJson<String>(json['clientId']),
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      priorityTier: serializer.fromJson<int>(json['priorityTier']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'clientId': serializer.toJson<String>(clientId),
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'priorityTier': serializer.toJson<int>(priorityTier),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'errorMessage': serializer.toJson<String?>(errorMessage),
    };
  }

  OutboxItem copyWith({
    int? id,
    String? entityType,
    String? clientId,
    String? idempotencyKey,
    String? payloadJson,
    int? priorityTier,
    String? status,
    int? retryCount,
    DateTime? createdAt,
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    Value<String?> errorMessage = const Value.absent(),
  }) => OutboxItem(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    clientId: clientId ?? this.clientId,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    payloadJson: payloadJson ?? this.payloadJson,
    priorityTier: priorityTier ?? this.priorityTier,
    status: status ?? this.status,
    retryCount: retryCount ?? this.retryCount,
    createdAt: createdAt ?? this.createdAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
  );
  OutboxItem copyWithCompanion(OutboxItemsCompanion data) {
    return OutboxItem(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      priorityTier: data.priorityTier.present
          ? data.priorityTier.value
          : this.priorityTier,
      status: data.status.present ? data.status.value : this.status,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxItem(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('clientId: $clientId, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('priorityTier: $priorityTier, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    clientId,
    idempotencyKey,
    payloadJson,
    priorityTier,
    status,
    retryCount,
    createdAt,
    lastAttemptAt,
    errorMessage,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxItem &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.clientId == this.clientId &&
          other.idempotencyKey == this.idempotencyKey &&
          other.payloadJson == this.payloadJson &&
          other.priorityTier == this.priorityTier &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.errorMessage == this.errorMessage);
}

class OutboxItemsCompanion extends UpdateCompanion<OutboxItem> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<String> clientId;
  final Value<String> idempotencyKey;
  final Value<String> payloadJson;
  final Value<int> priorityTier;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAttemptAt;
  final Value<String?> errorMessage;
  const OutboxItemsCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.clientId = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.priorityTier = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
  });
  OutboxItemsCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required String clientId,
    required String idempotencyKey,
    required String payloadJson,
    this.priorityTier = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    required DateTime createdAt,
    this.lastAttemptAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
  }) : entityType = Value(entityType),
       clientId = Value(clientId),
       idempotencyKey = Value(idempotencyKey),
       payloadJson = Value(payloadJson),
       createdAt = Value(createdAt);
  static Insertable<OutboxItem> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<String>? clientId,
    Expression<String>? idempotencyKey,
    Expression<String>? payloadJson,
    Expression<int>? priorityTier,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAttemptAt,
    Expression<String>? errorMessage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (clientId != null) 'client_id': clientId,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (priorityTier != null) 'priority_tier': priorityTier,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (errorMessage != null) 'error_message': errorMessage,
    });
  }

  OutboxItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? entityType,
    Value<String>? clientId,
    Value<String>? idempotencyKey,
    Value<String>? payloadJson,
    Value<int>? priorityTier,
    Value<String>? status,
    Value<int>? retryCount,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastAttemptAt,
    Value<String?>? errorMessage,
  }) {
    return OutboxItemsCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      clientId: clientId ?? this.clientId,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      payloadJson: payloadJson ?? this.payloadJson,
      priorityTier: priorityTier ?? this.priorityTier,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (priorityTier.present) {
      map['priority_tier'] = Variable<int>(priorityTier.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxItemsCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('clientId: $clientId, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('priorityTier: $priorityTier, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('errorMessage: $errorMessage')
          ..write(')'))
        .toString();
  }
}

class $LookupValuesTable extends LookupValues
    with TableInfo<$LookupValuesTable, LookupValue> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LookupValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _lookupTableCodeMeta = const VerificationMeta(
    'lookupTableCode',
  );
  @override
  late final GeneratedColumn<String> lookupTableCode = GeneratedColumn<String>(
    'lookup_table_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    lookupTableCode,
    code,
    label,
    metadataJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lookup_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<LookupValue> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('lookup_table_code')) {
      context.handle(
        _lookupTableCodeMeta,
        lookupTableCode.isAcceptableOrUnknown(
          data['lookup_table_code']!,
          _lookupTableCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lookupTableCodeMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {lookupTableCode, code};
  @override
  LookupValue map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LookupValue(
      lookupTableCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lookup_table_code'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      ),
    );
  }

  @override
  $LookupValuesTable createAlias(String alias) {
    return $LookupValuesTable(attachedDatabase, alias);
  }
}

class LookupValue extends DataClass implements Insertable<LookupValue> {
  final String lookupTableCode;
  final String code;
  final String label;
  final String? metadataJson;
  const LookupValue({
    required this.lookupTableCode,
    required this.code,
    required this.label,
    this.metadataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['lookup_table_code'] = Variable<String>(lookupTableCode);
    map['code'] = Variable<String>(code);
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    return map;
  }

  LookupValuesCompanion toCompanion(bool nullToAbsent) {
    return LookupValuesCompanion(
      lookupTableCode: Value(lookupTableCode),
      code: Value(code),
      label: Value(label),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
    );
  }

  factory LookupValue.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LookupValue(
      lookupTableCode: serializer.fromJson<String>(json['lookupTableCode']),
      code: serializer.fromJson<String>(json['code']),
      label: serializer.fromJson<String>(json['label']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'lookupTableCode': serializer.toJson<String>(lookupTableCode),
      'code': serializer.toJson<String>(code),
      'label': serializer.toJson<String>(label),
      'metadataJson': serializer.toJson<String?>(metadataJson),
    };
  }

  LookupValue copyWith({
    String? lookupTableCode,
    String? code,
    String? label,
    Value<String?> metadataJson = const Value.absent(),
  }) => LookupValue(
    lookupTableCode: lookupTableCode ?? this.lookupTableCode,
    code: code ?? this.code,
    label: label ?? this.label,
    metadataJson: metadataJson.present ? metadataJson.value : this.metadataJson,
  );
  LookupValue copyWithCompanion(LookupValuesCompanion data) {
    return LookupValue(
      lookupTableCode: data.lookupTableCode.present
          ? data.lookupTableCode.value
          : this.lookupTableCode,
      code: data.code.present ? data.code.value : this.code,
      label: data.label.present ? data.label.value : this.label,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LookupValue(')
          ..write('lookupTableCode: $lookupTableCode, ')
          ..write('code: $code, ')
          ..write('label: $label, ')
          ..write('metadataJson: $metadataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(lookupTableCode, code, label, metadataJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LookupValue &&
          other.lookupTableCode == this.lookupTableCode &&
          other.code == this.code &&
          other.label == this.label &&
          other.metadataJson == this.metadataJson);
}

class LookupValuesCompanion extends UpdateCompanion<LookupValue> {
  final Value<String> lookupTableCode;
  final Value<String> code;
  final Value<String> label;
  final Value<String?> metadataJson;
  final Value<int> rowid;
  const LookupValuesCompanion({
    this.lookupTableCode = const Value.absent(),
    this.code = const Value.absent(),
    this.label = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LookupValuesCompanion.insert({
    required String lookupTableCode,
    required String code,
    required String label,
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : lookupTableCode = Value(lookupTableCode),
       code = Value(code),
       label = Value(label);
  static Insertable<LookupValue> custom({
    Expression<String>? lookupTableCode,
    Expression<String>? code,
    Expression<String>? label,
    Expression<String>? metadataJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (lookupTableCode != null) 'lookup_table_code': lookupTableCode,
      if (code != null) 'code': code,
      if (label != null) 'label': label,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LookupValuesCompanion copyWith({
    Value<String>? lookupTableCode,
    Value<String>? code,
    Value<String>? label,
    Value<String?>? metadataJson,
    Value<int>? rowid,
  }) {
    return LookupValuesCompanion(
      lookupTableCode: lookupTableCode ?? this.lookupTableCode,
      code: code ?? this.code,
      label: label ?? this.label,
      metadataJson: metadataJson ?? this.metadataJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (lookupTableCode.present) {
      map['lookup_table_code'] = Variable<String>(lookupTableCode.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LookupValuesCompanion(')
          ..write('lookupTableCode: $lookupTableCode, ')
          ..write('code: $code, ')
          ..write('label: $label, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FarmersTable farmers = $FarmersTable(this);
  late final $ProductionBatchesTable productionBatches =
      $ProductionBatchesTable(this);
  late final $VeterinaryRecordsTable veterinaryRecords =
      $VeterinaryRecordsTable(this);
  late final $OutboxItemsTable outboxItems = $OutboxItemsTable(this);
  late final $LookupValuesTable lookupValues = $LookupValuesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    farmers,
    productionBatches,
    veterinaryRecords,
    outboxItems,
    lookupValues,
  ];
}

typedef $$FarmersTableCreateCompanionBuilder =
    FarmersCompanion Function({
      required String id,
      Value<String?> serverId,
      Value<String?> farmerNumber,
      required String name,
      required String districtCode,
      Value<String?> community,
      Value<String?> phone,
      Value<String> status,
      Value<bool> documentationComplete,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$FarmersTableUpdateCompanionBuilder =
    FarmersCompanion Function({
      Value<String> id,
      Value<String?> serverId,
      Value<String?> farmerNumber,
      Value<String> name,
      Value<String> districtCode,
      Value<String?> community,
      Value<String?> phone,
      Value<String> status,
      Value<bool> documentationComplete,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$FarmersTableFilterComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmerNumber => $composableBuilder(
    column: $table.farmerNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get districtCode => $composableBuilder(
    column: $table.districtCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get community => $composableBuilder(
    column: $table.community,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get documentationComplete => $composableBuilder(
    column: $table.documentationComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FarmersTableOrderingComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmerNumber => $composableBuilder(
    column: $table.farmerNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get districtCode => $composableBuilder(
    column: $table.districtCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get community => $composableBuilder(
    column: $table.community,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get documentationComplete => $composableBuilder(
    column: $table.documentationComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FarmersTableAnnotationComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get farmerNumber => $composableBuilder(
    column: $table.farmerNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get districtCode => $composableBuilder(
    column: $table.districtCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get community =>
      $composableBuilder(column: $table.community, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get documentationComplete => $composableBuilder(
    column: $table.documentationComplete,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$FarmersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FarmersTable,
          Farmer,
          $$FarmersTableFilterComposer,
          $$FarmersTableOrderingComposer,
          $$FarmersTableAnnotationComposer,
          $$FarmersTableCreateCompanionBuilder,
          $$FarmersTableUpdateCompanionBuilder,
          (Farmer, BaseReferences<_$AppDatabase, $FarmersTable, Farmer>),
          Farmer,
          PrefetchHooks Function()
        > {
  $$FarmersTableTableManager(_$AppDatabase db, $FarmersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FarmersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FarmersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FarmersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String?> farmerNumber = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> districtCode = const Value.absent(),
                Value<String?> community = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> documentationComplete = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FarmersCompanion(
                id: id,
                serverId: serverId,
                farmerNumber: farmerNumber,
                name: name,
                districtCode: districtCode,
                community: community,
                phone: phone,
                status: status,
                documentationComplete: documentationComplete,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> serverId = const Value.absent(),
                Value<String?> farmerNumber = const Value.absent(),
                required String name,
                required String districtCode,
                Value<String?> community = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> documentationComplete = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FarmersCompanion.insert(
                id: id,
                serverId: serverId,
                farmerNumber: farmerNumber,
                name: name,
                districtCode: districtCode,
                community: community,
                phone: phone,
                status: status,
                documentationComplete: documentationComplete,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FarmersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FarmersTable,
      Farmer,
      $$FarmersTableFilterComposer,
      $$FarmersTableOrderingComposer,
      $$FarmersTableAnnotationComposer,
      $$FarmersTableCreateCompanionBuilder,
      $$FarmersTableUpdateCompanionBuilder,
      (Farmer, BaseReferences<_$AppDatabase, $FarmersTable, Farmer>),
      Farmer,
      PrefetchHooks Function()
    >;
typedef $$ProductionBatchesTableCreateCompanionBuilder =
    ProductionBatchesCompanion Function({
      required String id,
      Value<String?> serverId,
      Value<String?> batchNumber,
      required String farmId,
      required String pigIdsJson,
      Value<double?> weightKg,
      required DateTime recordedAt,
      Value<String?> notes,
      Value<String> status,
      required DateTime createdAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$ProductionBatchesTableUpdateCompanionBuilder =
    ProductionBatchesCompanion Function({
      Value<String> id,
      Value<String?> serverId,
      Value<String?> batchNumber,
      Value<String> farmId,
      Value<String> pigIdsJson,
      Value<double?> weightKg,
      Value<DateTime> recordedAt,
      Value<String?> notes,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$ProductionBatchesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductionBatchesTable> {
  $$ProductionBatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmId => $composableBuilder(
    column: $table.farmId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pigIdsJson => $composableBuilder(
    column: $table.pigIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductionBatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductionBatchesTable> {
  $$ProductionBatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmId => $composableBuilder(
    column: $table.farmId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pigIdsJson => $composableBuilder(
    column: $table.pigIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductionBatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductionBatchesTable> {
  $$ProductionBatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get batchNumber => $composableBuilder(
    column: $table.batchNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get farmId =>
      $composableBuilder(column: $table.farmId, builder: (column) => column);

  GeneratedColumn<String> get pigIdsJson => $composableBuilder(
    column: $table.pigIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$ProductionBatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductionBatchesTable,
          ProductionBatche,
          $$ProductionBatchesTableFilterComposer,
          $$ProductionBatchesTableOrderingComposer,
          $$ProductionBatchesTableAnnotationComposer,
          $$ProductionBatchesTableCreateCompanionBuilder,
          $$ProductionBatchesTableUpdateCompanionBuilder,
          (
            ProductionBatche,
            BaseReferences<
              _$AppDatabase,
              $ProductionBatchesTable,
              ProductionBatche
            >,
          ),
          ProductionBatche,
          PrefetchHooks Function()
        > {
  $$ProductionBatchesTableTableManager(
    _$AppDatabase db,
    $ProductionBatchesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductionBatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductionBatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductionBatchesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String?> batchNumber = const Value.absent(),
                Value<String> farmId = const Value.absent(),
                Value<String> pigIdsJson = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductionBatchesCompanion(
                id: id,
                serverId: serverId,
                batchNumber: batchNumber,
                farmId: farmId,
                pigIdsJson: pigIdsJson,
                weightKg: weightKg,
                recordedAt: recordedAt,
                notes: notes,
                status: status,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> serverId = const Value.absent(),
                Value<String?> batchNumber = const Value.absent(),
                required String farmId,
                required String pigIdsJson,
                Value<double?> weightKg = const Value.absent(),
                required DateTime recordedAt,
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime createdAt,
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductionBatchesCompanion.insert(
                id: id,
                serverId: serverId,
                batchNumber: batchNumber,
                farmId: farmId,
                pigIdsJson: pigIdsJson,
                weightKg: weightKg,
                recordedAt: recordedAt,
                notes: notes,
                status: status,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductionBatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductionBatchesTable,
      ProductionBatche,
      $$ProductionBatchesTableFilterComposer,
      $$ProductionBatchesTableOrderingComposer,
      $$ProductionBatchesTableAnnotationComposer,
      $$ProductionBatchesTableCreateCompanionBuilder,
      $$ProductionBatchesTableUpdateCompanionBuilder,
      (
        ProductionBatche,
        BaseReferences<
          _$AppDatabase,
          $ProductionBatchesTable,
          ProductionBatche
        >,
      ),
      ProductionBatche,
      PrefetchHooks Function()
    >;
typedef $$VeterinaryRecordsTableCreateCompanionBuilder =
    VeterinaryRecordsCompanion Function({
      required String id,
      Value<String?> serverId,
      Value<String?> recordNumber,
      required String pigId,
      required String type,
      Value<String?> vaccineTypeCode,
      required DateTime administeredAt,
      Value<String?> notes,
      required DateTime createdAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$VeterinaryRecordsTableUpdateCompanionBuilder =
    VeterinaryRecordsCompanion Function({
      Value<String> id,
      Value<String?> serverId,
      Value<String?> recordNumber,
      Value<String> pigId,
      Value<String> type,
      Value<String?> vaccineTypeCode,
      Value<DateTime> administeredAt,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$VeterinaryRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $VeterinaryRecordsTable> {
  $$VeterinaryRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordNumber => $composableBuilder(
    column: $table.recordNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pigId => $composableBuilder(
    column: $table.pigId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vaccineTypeCode => $composableBuilder(
    column: $table.vaccineTypeCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get administeredAt => $composableBuilder(
    column: $table.administeredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VeterinaryRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $VeterinaryRecordsTable> {
  $$VeterinaryRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordNumber => $composableBuilder(
    column: $table.recordNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pigId => $composableBuilder(
    column: $table.pigId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vaccineTypeCode => $composableBuilder(
    column: $table.vaccineTypeCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get administeredAt => $composableBuilder(
    column: $table.administeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VeterinaryRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VeterinaryRecordsTable> {
  $$VeterinaryRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get recordNumber => $composableBuilder(
    column: $table.recordNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pigId =>
      $composableBuilder(column: $table.pigId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get vaccineTypeCode => $composableBuilder(
    column: $table.vaccineTypeCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get administeredAt => $composableBuilder(
    column: $table.administeredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$VeterinaryRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VeterinaryRecordsTable,
          VeterinaryRecord,
          $$VeterinaryRecordsTableFilterComposer,
          $$VeterinaryRecordsTableOrderingComposer,
          $$VeterinaryRecordsTableAnnotationComposer,
          $$VeterinaryRecordsTableCreateCompanionBuilder,
          $$VeterinaryRecordsTableUpdateCompanionBuilder,
          (
            VeterinaryRecord,
            BaseReferences<
              _$AppDatabase,
              $VeterinaryRecordsTable,
              VeterinaryRecord
            >,
          ),
          VeterinaryRecord,
          PrefetchHooks Function()
        > {
  $$VeterinaryRecordsTableTableManager(
    _$AppDatabase db,
    $VeterinaryRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VeterinaryRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VeterinaryRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VeterinaryRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String?> recordNumber = const Value.absent(),
                Value<String> pigId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> vaccineTypeCode = const Value.absent(),
                Value<DateTime> administeredAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VeterinaryRecordsCompanion(
                id: id,
                serverId: serverId,
                recordNumber: recordNumber,
                pigId: pigId,
                type: type,
                vaccineTypeCode: vaccineTypeCode,
                administeredAt: administeredAt,
                notes: notes,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> serverId = const Value.absent(),
                Value<String?> recordNumber = const Value.absent(),
                required String pigId,
                required String type,
                Value<String?> vaccineTypeCode = const Value.absent(),
                required DateTime administeredAt,
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VeterinaryRecordsCompanion.insert(
                id: id,
                serverId: serverId,
                recordNumber: recordNumber,
                pigId: pigId,
                type: type,
                vaccineTypeCode: vaccineTypeCode,
                administeredAt: administeredAt,
                notes: notes,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VeterinaryRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VeterinaryRecordsTable,
      VeterinaryRecord,
      $$VeterinaryRecordsTableFilterComposer,
      $$VeterinaryRecordsTableOrderingComposer,
      $$VeterinaryRecordsTableAnnotationComposer,
      $$VeterinaryRecordsTableCreateCompanionBuilder,
      $$VeterinaryRecordsTableUpdateCompanionBuilder,
      (
        VeterinaryRecord,
        BaseReferences<
          _$AppDatabase,
          $VeterinaryRecordsTable,
          VeterinaryRecord
        >,
      ),
      VeterinaryRecord,
      PrefetchHooks Function()
    >;
typedef $$OutboxItemsTableCreateCompanionBuilder =
    OutboxItemsCompanion Function({
      Value<int> id,
      required String entityType,
      required String clientId,
      required String idempotencyKey,
      required String payloadJson,
      Value<int> priorityTier,
      Value<String> status,
      Value<int> retryCount,
      required DateTime createdAt,
      Value<DateTime?> lastAttemptAt,
      Value<String?> errorMessage,
    });
typedef $$OutboxItemsTableUpdateCompanionBuilder =
    OutboxItemsCompanion Function({
      Value<int> id,
      Value<String> entityType,
      Value<String> clientId,
      Value<String> idempotencyKey,
      Value<String> payloadJson,
      Value<int> priorityTier,
      Value<String> status,
      Value<int> retryCount,
      Value<DateTime> createdAt,
      Value<DateTime?> lastAttemptAt,
      Value<String?> errorMessage,
    });

class $$OutboxItemsTableFilterComposer
    extends Composer<_$AppDatabase, $OutboxItemsTable> {
  $$OutboxItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priorityTier => $composableBuilder(
    column: $table.priorityTier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OutboxItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $OutboxItemsTable> {
  $$OutboxItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priorityTier => $composableBuilder(
    column: $table.priorityTier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OutboxItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutboxItemsTable> {
  $$OutboxItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get priorityTier => $composableBuilder(
    column: $table.priorityTier,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );
}

class $$OutboxItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OutboxItemsTable,
          OutboxItem,
          $$OutboxItemsTableFilterComposer,
          $$OutboxItemsTableOrderingComposer,
          $$OutboxItemsTableAnnotationComposer,
          $$OutboxItemsTableCreateCompanionBuilder,
          $$OutboxItemsTableUpdateCompanionBuilder,
          (
            OutboxItem,
            BaseReferences<_$AppDatabase, $OutboxItemsTable, OutboxItem>,
          ),
          OutboxItem,
          PrefetchHooks Function()
        > {
  $$OutboxItemsTableTableManager(_$AppDatabase db, $OutboxItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<int> priorityTier = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
              }) => OutboxItemsCompanion(
                id: id,
                entityType: entityType,
                clientId: clientId,
                idempotencyKey: idempotencyKey,
                payloadJson: payloadJson,
                priorityTier: priorityTier,
                status: status,
                retryCount: retryCount,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
                errorMessage: errorMessage,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityType,
                required String clientId,
                required String idempotencyKey,
                required String payloadJson,
                Value<int> priorityTier = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
              }) => OutboxItemsCompanion.insert(
                id: id,
                entityType: entityType,
                clientId: clientId,
                idempotencyKey: idempotencyKey,
                payloadJson: payloadJson,
                priorityTier: priorityTier,
                status: status,
                retryCount: retryCount,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
                errorMessage: errorMessage,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OutboxItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OutboxItemsTable,
      OutboxItem,
      $$OutboxItemsTableFilterComposer,
      $$OutboxItemsTableOrderingComposer,
      $$OutboxItemsTableAnnotationComposer,
      $$OutboxItemsTableCreateCompanionBuilder,
      $$OutboxItemsTableUpdateCompanionBuilder,
      (
        OutboxItem,
        BaseReferences<_$AppDatabase, $OutboxItemsTable, OutboxItem>,
      ),
      OutboxItem,
      PrefetchHooks Function()
    >;
typedef $$LookupValuesTableCreateCompanionBuilder =
    LookupValuesCompanion Function({
      required String lookupTableCode,
      required String code,
      required String label,
      Value<String?> metadataJson,
      Value<int> rowid,
    });
typedef $$LookupValuesTableUpdateCompanionBuilder =
    LookupValuesCompanion Function({
      Value<String> lookupTableCode,
      Value<String> code,
      Value<String> label,
      Value<String?> metadataJson,
      Value<int> rowid,
    });

class $$LookupValuesTableFilterComposer
    extends Composer<_$AppDatabase, $LookupValuesTable> {
  $$LookupValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get lookupTableCode => $composableBuilder(
    column: $table.lookupTableCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LookupValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $LookupValuesTable> {
  $$LookupValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get lookupTableCode => $composableBuilder(
    column: $table.lookupTableCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LookupValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LookupValuesTable> {
  $$LookupValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get lookupTableCode => $composableBuilder(
    column: $table.lookupTableCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );
}

class $$LookupValuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LookupValuesTable,
          LookupValue,
          $$LookupValuesTableFilterComposer,
          $$LookupValuesTableOrderingComposer,
          $$LookupValuesTableAnnotationComposer,
          $$LookupValuesTableCreateCompanionBuilder,
          $$LookupValuesTableUpdateCompanionBuilder,
          (
            LookupValue,
            BaseReferences<_$AppDatabase, $LookupValuesTable, LookupValue>,
          ),
          LookupValue,
          PrefetchHooks Function()
        > {
  $$LookupValuesTableTableManager(_$AppDatabase db, $LookupValuesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LookupValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LookupValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LookupValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> lookupTableCode = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LookupValuesCompanion(
                lookupTableCode: lookupTableCode,
                code: code,
                label: label,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String lookupTableCode,
                required String code,
                required String label,
                Value<String?> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LookupValuesCompanion.insert(
                lookupTableCode: lookupTableCode,
                code: code,
                label: label,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LookupValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LookupValuesTable,
      LookupValue,
      $$LookupValuesTableFilterComposer,
      $$LookupValuesTableOrderingComposer,
      $$LookupValuesTableAnnotationComposer,
      $$LookupValuesTableCreateCompanionBuilder,
      $$LookupValuesTableUpdateCompanionBuilder,
      (
        LookupValue,
        BaseReferences<_$AppDatabase, $LookupValuesTable, LookupValue>,
      ),
      LookupValue,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FarmersTableTableManager get farmers =>
      $$FarmersTableTableManager(_db, _db.farmers);
  $$ProductionBatchesTableTableManager get productionBatches =>
      $$ProductionBatchesTableTableManager(_db, _db.productionBatches);
  $$VeterinaryRecordsTableTableManager get veterinaryRecords =>
      $$VeterinaryRecordsTableTableManager(_db, _db.veterinaryRecords);
  $$OutboxItemsTableTableManager get outboxItems =>
      $$OutboxItemsTableTableManager(_db, _db.outboxItems);
  $$LookupValuesTableTableManager get lookupValues =>
      $$LookupValuesTableTableManager(_db, _db.lookupValues);
}
