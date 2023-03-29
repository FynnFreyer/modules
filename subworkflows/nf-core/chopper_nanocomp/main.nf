include { CHOPPER                      } from '../../../modules/nf-core/chopper/main'
include { NANOCOMP as NANOCOMP_RAW     } from '../../../modules/nf-core/nanocomp/main'
include { NANOCOMP as NANOCOMP_TRIMMED } from '../../../modules/nf-core/nanocomp/main'

workflow CHOPPER_NANOCOMP {

    take:
    ch_fastq // channel: [ val(meta), [ fastq ] ]

    main:

    ch_versions = Channel.empty()

    CHOPPER ( ch_fastq )
    ch_versions = ch_versions.mix(CHOPPER.out.versions.first())

    NANOCOMP_RAW     ( ch_fastq )
    NANOCOMP_TRIMMED ( CHOPPER.out.fastq )
    ch_versions = ch_versions.mix(NANOCOMP.out.versions.first())

    emit:
    // TODO nf-core: edit emitted channels
    fastq         = CHOPPER.out.fastq           // channel: [ val(meta), [ fastq ] ]
    html_raw      = NANOCOMP.out.html           // channel: [ val(meta), [ html ] ]
    html_trimmed  = NANOCOMP.out.html           // channel: [ val(meta), [ html ] ]

    versions = ch_versions                      // channel: [ versions.yml ]
}

