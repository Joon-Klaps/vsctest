
process BEAST_GPU {
    tag "$meta.id"
    label 'process_gpu'

    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        '/lustre1/project/stg_00132/jklaps/genus-coronaviridae/beast/testing/singularity-def/beagle-lib_beast.wouter.sif':
        'jklaps/beast-beagle-cuda:latest' }"

    input:
    tuple val(meta), path(bam)

    output:
    path "*.gpu.info"          , emit: info
    path "versions.yml"        , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    beast -beagle_info > ${prefix}.gpu.info

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        beast: V1.10
    END_VERSIONS
    """

    stub:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    touch ${prefix}.bam

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        beast: V1.10
    END_VERSIONS
    """

}
